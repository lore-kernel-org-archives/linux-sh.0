From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 May 2008 22:15:59 +0000
Subject: Re: + mm-define-default-cpu_to_node-checkpatch-fixes.patch added to -mm tree
Message-Id: <20080509221559.GA12762@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4824C48B.6030808@sgi.com>
In-Reply-To: <4824C48B.6030808@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 09, 2008 at 02:46:41PM -0700, Andrew Morton wrote:
> On Fri, 09 May 2008 14:39:23 -0700
> Mike Travis <travis@sgi.com> wrote:
> 
> > I thought Paul had submitted a patch to add the stubs from
> > asm-generic/topology.h to asm-sh/topology.h, replacing this
> > patch entirely?
> 
> I lost track of what was what.

The patch for that was lumped in with my merge request to Linus, though
as was noted before, that still doesn't fix the MIPS sgi-ip27 case. Ralf
was CC'ed on the original thread, so hopefully someone there will take
notice. MIPS is the only platform still broken in current git with
regards to a missing set of definitions.
