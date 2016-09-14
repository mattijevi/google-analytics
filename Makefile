all: wiki

# experimental autogenerated interface documentation
doc_fn := --include documented --markdown 5
doc_cls := --include members.documented --markdown 5

readme:
	pandoc -o README.rst README.md

.PHONY: docs
docs: readme
	inspect googleanalytics.auth $(doc_fn) > docs/google-analytics.wiki/Python\ API\ Reference/auth.md
	inspect googleanalytics.account $(doc_cls) > docs/google-analytics.wiki/Python\ API\ Reference/Account.md
	inspect googleanalytics.query $(doc_cls) > docs/google-analytics.wiki/Python\ API\ Reference/Query.md

test:
	python3 setup.py test

wiki: docs
	cd docs/google-analytics.wiki && git add . --all && \
	git commit --message "Update autogenerated interface documentation." && \
	git push

clean:
	rm -rf googleanalytics.egg-info
	rm -rf build
	rm -rf dist

package: readme
	python3 setup.py sdist upload
