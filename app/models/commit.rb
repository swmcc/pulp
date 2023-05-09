class Commit < ApplicationRecord
  validates :repo_name, presence: true
  validates :sha, presence: true
  validates :message, presence: true
  validates :commit_date, presence: true

  def self.grouped_by_repo_and_date
   # grouped_commits = Commit.select(:sha, :message, :repo_name, :commit_date)
   #     .order(repo_name: :asc, commit_date: :desc)
   #     .group_by(&:repo_name)

    # Transform the ActiveRecord::Relation objects into arrays and map to a hash
    #grouped_commits_transformed = grouped_commits.transform_values do |commits|
    #    commits.map do |commit|
    #        { id: commit.id, sha: commit.sha, message: commit.message, commit_date: commit.commit_date.strftime('%Y-%m-%d'), commit_time: commit.commit_date.strftime('%H:%M:%S') }
    #    end
    #end

    #grouped_commits_transformed

    commits = Commit.order(:commit_date)
                    .pluck(:repo_name, :message, :sha, :commit_date)
                    .group_by(&:first)

    result = commits.transform_values do |values|
      values.map do |value|
        {
          message: value[1],
          sha: value[2],
          commit_date: value[3]
        }
      end
    end

    result
    end
end
