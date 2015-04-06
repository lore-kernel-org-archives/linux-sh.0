From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Apr 2015 00:23:54 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7791: Remove MSIOF address from device tree
Message-Id: <20150406002353.GB1841@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1428166512-2936-1-git-send-email-ykaneko0929@gmail.com>
 <CAMuHMdVH19ZncC0dMbO8-rCzN6MkOVWfiSKLDAnsqW6_Z_pw1Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVH19ZncC0dMbO8-rCzN6MkOVWfiSKLDAnsqW6_Z_pw1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, Apr 05, 2015 at 10:47:01AM +0200, Geert Uytterhoeven wrote:
> On Sat, Apr 4, 2015 at 6:55 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
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
