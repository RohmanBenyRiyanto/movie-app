# make create_feature name=example_feature
create_feature:
	flutter create --template=package ./module/features/$(name)

# make create_module name=example_module
create_module:
	flutter create --template=package ./module/$(name)
