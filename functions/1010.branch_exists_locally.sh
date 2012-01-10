## /* @function
#	@usage __branch_exists_locally <branch_name>
#
#	@output false
#
#	@description
#	Determine if the given branch exists locally.
#	description@
#
#	@notes
#	- Since this function does not echo anything to be captured, it is most useful if
#	used directly in conditional statements. See example below.
#	notes@
#
#	@examples
#	# ...
#
#	if __branch_exists_locally master; then
#		echo "local branch 'master' exists!"
#	fi
#
#	#...
#	examples@
## */
function __branch_exists_locally {
	if [ -z "$1" ]; then
		__gslog "__branch_exists_locally: First parameter must be branch name."
		return 1
	fi

	local locally=$(git branch | grep "$1")
	if [ -n "$locally" ]; then
		return 0
	fi
	return 1
}