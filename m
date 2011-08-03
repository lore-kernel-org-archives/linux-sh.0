From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 03 Aug 2011 01:53:46 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7367 SCIF platform data update
Message-Id: <20110803015346.GC32513@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110802094639.2671.15167.sendpatchset@t400s>
In-Reply-To: <20110802094639.2671.15167.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 02, 2011 at 06:46:39PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add .regtype members to the sh7367 SCIF platform data.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Why? sci_probe_regmap() should already handle these cases fine.
