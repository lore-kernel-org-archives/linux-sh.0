From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Nov 2010 08:35:18 +0000
Subject: [ANNOUNCE] Changes in the SH and Genesis/R-Mobile git trees
Message-Id: <20101109083518.GA21086@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The current scheme with the split out trees simply wasn't scaling well,
with too many interdependencies and confusion about where to do what. As
such, and after talking to Linus about what he was the most comfortable
with, I've come up with a scheme loosely modelled after -tip.

The first change to note is the naming one. While genesis worked fine for
the SH-Mobile G series, it's no longer terribly helpful now that the
ARM/SH multi-cores have moved beyond the G series, and newer parts will
be using R-Mobile naming. Having said that, we will not be moving off of
the SH-Mobile naming in the kernel proper simply because there is no
architectural difference. Separate R-Mobile symbols may be introduced in
the future if they diverge from the current ARM-based SH-Mobile parts
sufficiently.

rmobile/
sh/
	- Are the new (or existing in the sh case) namespaces for all of
	  the targetted topic branches. Topic branches will be created
	  and destroyed as necessary over time, with most having no
	  logical connection to any other branches. Some of these may be
	  branched off of or pulled in to other trees as the need arises.

rmobile-fixes-for-linus / sh-fixes-for-linus
	- These are my pull branches for upstream. They will always
	  contain that which is bound for the next -rc, regardless of
	  whether we are in a merge window or late in an -rc series. They
	  will only be advanced as new things come in that need to be
	  merged in to the next -rc, and may very well stay put for
	  awhile if I've just completed a merge and all of the new
	  patches are aimed at the next kernel.

rmobile-latest / sh-latest
	- These contain the newest changes and are each an integration of
	  their respective namespaces. These are what get pulled (or what
	  I would like to have pulled) in to -next, and so will only be
	  advanced with next merge window patches once we're in an -rc2
	  phase, as per standard -next guidelines. These are basically
	  identical to the old master branch behaviour for the previous
	  genesis and sh trees.
	  
	  While these are suitable for doing testing and development
	  against, folks are encouraged to focus on specific and isolated
	  topic branches for the highest degree of flexibility going
	  forward (if you find yourself in need of changes from one
	  or more branches in order to build a logical set on another,
	  just make a note of it when posting the patch series).

master
	- This will now be an integration branch of the latest sh,
	  rmobile, and whatever other architectures we end up with
	  changes. This will not be rebased or pulled by any upstream,
	  but people are advised to use the topic branches that relate
	  to their areas of interest and need. This will provide the best
	  idea of what the next kernel will look like once all of the
	  changes from the other branches have been merged.

I also plan to gradually introduce a separate namespace for development
of shared blocks, split between rmobile/sh/common components, which will
in turn be merged back in to whichever localized topic or integration
branches need them. This will become readily apparent once new branches
start appearing and people become gradually more aware of the branch
topology and interaction.
