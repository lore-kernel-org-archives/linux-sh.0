From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Sep 2010 02:58:33 +0000
Subject: Re: [PATCH] sh/shmobile: move clk-cpg related functions from clc.c to clk-cpg.c
Message-Id: <20100902025833.GE10947@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 31, 2010 at 12:09:28PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> move clk_rate_table_build, clk_rate_table_round and clk_rate_table_find
> from clc.c to clk-cpg.c as there are only for CPG clock support
> 
No. These are generic helper routines related to the sh struct clk
definition, located in linux/sh_clk.h. Nothing about this has anything to
do with the CPG.
