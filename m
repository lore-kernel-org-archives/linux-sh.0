From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Dec 2010 09:50:17 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Fix up pinmux entries in Makefile
Message-Id: <20101214095017.GF14606@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101214071535.11037.17853.sendpatchset@t400s>
In-Reply-To: <20101214071535.11037.17853.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 14, 2010 at 04:15:35PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Compiling in multiple CPUs into the same kernel binary
> requires a Makefile update. With this patch in place
> it is possible to enable the pinmux code for both the
> SH7372 and the SH7377.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied to rmobile-latest, thanks.
