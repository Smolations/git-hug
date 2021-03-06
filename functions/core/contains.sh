## /*
#   @usage contains [--not] <branch-name>
#
#   @description
#   Checks to see which other branches the branch you specify has merged into it. If
#   no branch is specified, the current branch is used.
#   description@
#
#   @options
#   --not   Pass this option to view a list of all branches which do NOT contain
#           the specified (or current) branch.
#   options@
#
#   @examples
#   1) contains --not my-branch
#       # will display all branches that don't contain my-branch
#   2) contains
#       # will display all branches which contain the current branch
#   examples@
#
#   @dependencies
#   functions/5000.branch_exists_local.sh
#   functions/5000.parse_git_branch.sh
#   dependencies@
#
#   @file contains.sh
## */

function contains {
    # parse args
    _.inArgs not "$@" && isNot=true && frag=" do NOT"
    branch="${_args_clipped[@]}"

    if [ -z "$branch" ]; then
        # use current branch if none specified
        branch=$( gh_parse_git_branch )

    elif ! gh_branch_exists_local "$branch"; then
        echo "${E}  The branch \`${branch}\` does not exist locally. Aborting...  ${X}"
        return 1
    fi


    # echo ${H1}${H1HL}
    echo "Listing any branches which${A}${frag}${X} contain:  ${BN}\`${branch}\`${X}"
    # echo ${H1HL}${X}
    # echo
    # echo

    if [ $isNot ]; then
        # echo "The following branches ${COL_RED}DO NOT${COL_NORM} contain the latest version of ${B}\`${branch}\`${X}:"
        # echo ${O}${H2HL}${X}

        for br in `git branch | sed 's/\*//'`; do
            git branch --contains "${branch}" | grep -q "$br" || echo "${COL_RED}${br}${COL_NORM}"
        done

        # echo ${O}${H2HL}${X}

    else
        # echo "The following branches contain the latest version of ${B}\`${branch}\`${X}:"
        # echo ${O}${H2HL}${X}
        git branch --contains "$branch"
        # echo ${O}${H2HL}${X}
    fi
}
