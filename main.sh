#!/bin/bash

git fetch --prune

# 获取所有本地分支
local_branches=($(git branch | cut -c 3-))

# 获取所有远程分支
remote_branches=($(git branch -r | cut -d "/" -f 2))

# 找出没有对应远程分支的本地分支
unset untracked_branches
for branch in "${local_branches[@]}"
do
    if [[ ! " ${remote_branches[@]} " =~ " $branch " ]]; then
        untracked_branches+=("$branch")
    fi
done

# 输出没有对应远程分支的本地分支
for branch in "${untracked_branches[@]}"
do
    echo "Branch without corresponding remote branch: $branch"
done

# 删除没有对应远程分支的本地分支
for branch in "${untracked_branches[@]}"
do
    git branch -D "$branch"
    echo "Deleted local branch: $branch"
done
