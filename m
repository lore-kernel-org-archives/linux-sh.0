From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 13 Sep 2014 20:45:00 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: sh73a0: Remove unnecessary SoC data allocation
Message-Id: <1487230.tW8LvMkrfL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1410386155-3896-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410386155-3896-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday 11 September 2014 09:12:22 Geert Uytterhoeven wrote:
> On Wed, Sep 10, 2014 at 11:55 PM, Laurent Pinchart wrote:
> > The SoC data structure allocated at init time only holds a regulator
> > pointer that is only used in the init function. Replace it with a local
> > variable and get rid of the SoC data structure allocation altogether.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you. Linus, could you please pick this up for v3.18 ?

-- 
Regards,

Laurent Pinchart

