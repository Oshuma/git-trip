Gem::Specification.new do |s|
  s.name = 'git-trip'
  s.version = '0.0.5'
  s.authors = ['Dale Campbell']
  s.email = ['dale@save-state.net']
  s.homepage = 'http://git-trip.rubyforge.org'
  s.date = %q{2008-07-08}
  s.summary = %q{Visualize git commit SHAs.}
  s.description = %q{Visualize git commit SHAs.  It's nerd acid!}

  s.rubyforge_project = %q{git-trip}
  s.rubygems_version = %q{1.2.0}

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/git-trip", "doc/USAGE.txt", "lib/core_ext/hash.rb", "lib/git-trip.rb", "lib/git-trip/errors.rb", "lib/git-trip/gitter.rb", "lib/git-trip/gitter/base.rb", "lib/git-trip/gitter/dir.rb", "lib/git-trip/gitter/uri.rb", "lib/git-trip/paint_mode.rb", "lib/git-trip/painter.rb", "spec/core_ext/hash_spec.rb", "spec/git-trip/errors_spec.rb", "spec/git-trip/gitter/base_spec.rb", "spec/git-trip/gitter/dir_spec.rb", "spec/git-trip/gitter/uri_spec.rb", "spec/git-trip/gitter_spec.rb", "spec/git-trip/paint_mode_spec.rb", "spec/git-trip/painter_spec.rb", "spec/git_trip_spec.rb", "spec/rcov.opts", "spec/spec.opts", "spec/spec_helper.rb", "tasks/ditz.rake", "tasks/docs.rake", "tasks/gittrip.rake", "tasks/rspec.rake", "tasks/site.rake", "tasks/util.rake", "vendor/grit/History.txt", "vendor/grit/Manifest.txt", "vendor/grit/README.txt", "vendor/grit/Rakefile", "vendor/grit/grit.gemspec", "vendor/grit/lib/grit.rb", "vendor/grit/lib/grit/actor.rb", "vendor/grit/lib/grit/blob.rb", "vendor/grit/lib/grit/commit.rb", "vendor/grit/lib/grit/config.rb", "vendor/grit/lib/grit/diff.rb", "vendor/grit/lib/grit/errors.rb", "vendor/grit/lib/grit/git.rb", "vendor/grit/lib/grit/index.rb", "vendor/grit/lib/grit/lazy.rb", "vendor/grit/lib/grit/ref.rb", "vendor/grit/lib/grit/repo.rb", "vendor/grit/lib/grit/tree.rb", "vendor/grit/test/fixtures/blame", "vendor/grit/test/fixtures/cat_file_blob", "vendor/grit/test/fixtures/cat_file_blob_size", "vendor/grit/test/fixtures/diff_2", "vendor/grit/test/fixtures/diff_2f", "vendor/grit/test/fixtures/diff_f", "vendor/grit/test/fixtures/diff_i", "vendor/grit/test/fixtures/diff_mode_only", "vendor/grit/test/fixtures/diff_new_mode", "vendor/grit/test/fixtures/diff_p", "vendor/grit/test/fixtures/for_each_ref", "vendor/grit/test/fixtures/for_each_ref_remotes", "vendor/grit/test/fixtures/for_each_ref_tags", "vendor/grit/test/fixtures/ls_tree_a", "vendor/grit/test/fixtures/ls_tree_b", "vendor/grit/test/fixtures/ls_tree_commit", "vendor/grit/test/fixtures/rev_list", "vendor/grit/test/fixtures/rev_list_count", "vendor/grit/test/fixtures/rev_list_single", "vendor/grit/test/fixtures/rev_parse", "vendor/grit/test/fixtures/show_empty_commit", "vendor/grit/test/fixtures/simple_config", "vendor/grit/test/helper.rb", "vendor/grit/test/profile.rb", "vendor/grit/test/suite.rb", "vendor/grit/test/test_actor.rb", "vendor/grit/test/test_blob.rb", "vendor/grit/test/test_commit.rb", "vendor/grit/test/test_config.rb", "vendor/grit/test/test_diff.rb", "vendor/grit/test/test_git.rb", "vendor/grit/test/test_head.rb", "vendor/grit/test/test_real.rb", "vendor/grit/test/test_reality.rb", "vendor/grit/test/test_remote.rb", "vendor/grit/test/test_repo.rb", "vendor/grit/test/test_tag.rb", "vendor/grit/test/test_tree.rb"]

  s.has_rdoc = true
  s.remote_rdoc_dir = 'api'
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt", "doc/USAGE.txt"]
  rdoc_title = 'GitTrip v0.0.5 Documentation'
  s.rdoc_options = ["--main", "README.txt", '--all', '--inline-source', '--line-numbers', "--title #{rdoc_title}"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<hoe>, [">= 1.6.0"])
    else
      s.add_dependency(%q<hoe>, [">= 1.6.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.6.0"])
  end
end
