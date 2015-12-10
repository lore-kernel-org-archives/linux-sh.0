From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Dec 2015 07:04:48 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
Message-Id: <20151210070447.GC17682@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890534-1430-1-git-send-email-geert+renesas@glider.be>
 <20151201064434.GI16260@verge.net.au>
 <CAMuHMdWy3BWSe7ASwN4JejoJR8cDT06gSA5d+bPSRB7COR3Mzg@mail.gmail.com>
In-Reply-To: <CAMuHMdWy3BWSe7ASwN4JejoJR8cDT06gSA5d+bPSRB7COR3Mzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 09, 2015 at 10:28:22AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Dec 1, 2015 at 7:44 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Nov 30, 2015 at 02:35:34PM +0100, Geert Uytterhoeven wrote:
> >> Enable timestamps for kernel log output to improve debugging.
> >> You can always use "dmesg -t" to strip the timestamps.
> >>
> >> Don't specify CONFIG_LOG_BUF_SHIFT while we're at it.  There's a
> >> reason the default in Kconfig is higher ;-)
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks, I have queued this up.
> 
> Still not present in renesas-devel?

Sorry about that, it should appear there soon.
