From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 08 Jun 2013 20:24:04 +0000
Subject: Re: [PATCH v9 0/3] Add USB support to R8A7778/BOCK-W
Message-Id: <51B392E4.1040201@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306090013.00313.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306090013.00313.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/09/2013 12:12 AM, Sergei Shtylyov wrote:

>     Here's the set of 3 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130607' tag, and the R8A7779/Marzen USB patchset I've posted.
> It was created to add support of R8A7778/BOCK-W USB to the platform code and
> the USB common PHY driver, and so spans both arch/arm/mach-shmobile/ and
> drivers/usb/phy/ subtrees.
>
> [1/3] phy-rcar-usb: add R8A7778 support
> [2/3] ARM: shmobile: r8a7778: add USB support
> [3/3] ARM: shmobile: BOCK-W: add USB support
>
>     The patch #4 (ARM: shmobile: BOCK-W: enable USB in defconfig) that has been
> already merged, is not reposted.
>
>     The patchset is completely ready for merging now.

    Argh, scratch that -- I forgot to refresh the patches before sending...

WBR, Sergei


