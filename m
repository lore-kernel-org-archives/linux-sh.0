From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Mar 2009 05:49:04 +0000
Subject: Re: [PATCH] sh_clk: added clk_set_parent/clk_get_parent support
Message-Id: <20090311054904.GA6281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B66867.2010406@st.com>
In-Reply-To: <49B66867.2010406@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 12:00:05PM +0900, Magnus Damm wrote:
> Hi Francesco,
> 
> Thanks for your work on this!
> 
> On Tue, Mar 10, 2009 at 10:17 PM, Francesco VIRLINZI
> <francesco.virlinzi@st.com> wrote:
> > I would add the following functions in the clock framework
> > - clk_set_parent
> > - clk_get_parent
> 
> 1) I agree about adding the functions above.
> 
> > and the utility function
> > - clk_for_each
> 
> 2) As much as I like functions like this, where is this used?
> 
> (From patch header)
> > - changes the callback function to return a value
> 
> 3) These changes break other code. You need to update cpu/sh4a/clock-*
> files as well. I agree about init and enable, but why does the disable
> callback need to return something?
> 
> Please break out 1) and resubmit it inline to begin with. Let's deal
> with 2) and 3) separately.
> 
Agreed. 1) can be merged as is, as it doesn't really impact anything, and
matches updates to linux/clk.h, even if we don't use them today. 2) needs
a user before we consider merging it, and 3) needs to include the updates
to all of the clock files if we are to merge it, as this change will have
to be made in one shot. It's not clear why the return value is something
we care about in most of these cases, so I'm rather less enthusiastic
about making such a sweeping change.

For now, I'll fold 1) in to the tree. 2) and 3) can be added later if and
when the aforementioned issues are resolved.
