require 'wukong'
module DistributionSorter
  class Mapper < Wukong::Streamer::Base
    # set record_klass to the AR class you'd like to batch process
    cattr_accessor :record_klass
    # Size of each batch to pull from db
    cattr_accessor :batch_size

    def initialize
      # TODO: remove klass from here and just pass it in the new hash
      self.record_klass = PropertyMedium
      self.batch_size = 100
    end

    def stream
      # keep before_stream & after_stream in, it is convention
      before_stream
      record_klass.find_in_batches(:batch_size => self.batch_size) do |record_batch|
        record_batch.each do |record|
          process(record.id, record) do |output_record|
            emit output_record
          end
        end
      end
      after_stream
    end
  end

  # TODO: which reduce pattern to use?
  class Reducer < Wukong::Streamer
    def finalize
      yield [output_record]
    end
  end

end
