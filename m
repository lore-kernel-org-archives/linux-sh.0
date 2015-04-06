From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Apr 2015 00:24:16 +0000
Subject: Re: [PATCH repost] ARM: shmobile: r8a7790: Remove MSIOF address from device tree
Message-Id: <20150406002411.GC1841@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1428166471-2897-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdW40S4rU-wkrJDHDw_ThFdChEa+HEyXYHJ3AAH1TwUiVw@mail.gmail.com>
In-Reply-To: <CAMuHMdW40S4rU-wkrJDHDw_ThFdChEa+HEyXYHJ3AAH1TwUiVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Apr 05, 2015 at 10:46:33AM +0200, Geert Uytterhoeven wrote:
> On Sat, Apr 4, 2015 at 6:54 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> > From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> >
> > MSIOF Base Address H'E6xx can be accessed by CPU and DMAC.
> > MSIOF Base Address H'E7xx for DMAC was removed from H/W manual.
> >
> > Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v4.2.
