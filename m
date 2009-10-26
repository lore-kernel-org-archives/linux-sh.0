From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 10:59:18 +0000
Subject: Re: [PATCH] sh: fix kexec by removing check for old kexec-tools
Message-Id: <20091026105918.GB7611@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026103048.24085.71003.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026103048.24085.71003.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Oct 26, 2009 at 07:30:48PM +0900, Magnus Damm wrote:
> This unbreaks kexec support. Without this fix all
> cases of kexec fails since __pa() does not behave
> like PHYSADDR(). The downside is that we also kill
> the code blocking users running old kexec-tools.

On Mon, Oct 26, 2009 at 07:41:58PM +0900, Magnus Damm wrote:
> Add HWBLK_ETHER to the sh_eth platform device
> to allow Runtime PM of the ethernet hardware.

On Mon, Oct 26, 2009 at 07:44:37PM +0900, Magnus Damm wrote:
> Convert the ecovec24 board code to pass the mac
> address to the sh_eth driver using platform data.
> Also, remove the static clock to allow Runtime PM.

Applied for 2.6.33, thanks.
