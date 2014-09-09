From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Sep 2014 22:08:30 +0000
Subject: Re: [PATCH v2 09/10] clk: shmobile: div6: support selectable-input clocks
Message-Id: <2710453.IBnWdqPGTi@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-10-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-10-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Wednesday 03 September 2014 09:48:28 Ulrich Hecht wrote:
> On Wed, Sep 3, 2014 at 12:45 AM, Mike Turquette wrote:
> > Quoting Ulrich Hecht (2014-09-02 02:13:05)
> > 
> >> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> >> 
> >> Support for setting the parent at initialization time based on the
> >> current hardware configuration in DIV6 clocks with selectable parents as
> >> found in the r8a73a4, r8a7740, sh73a0, and other SoCs.
> >> 
> >> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > I still have the same question about switching parents at run-time as I
> > did in the last posting[0]. Is there a use case for modeling this clocks
> > as proper muxes and switching parents dynamically?
> 
> I have no idea, frankly. Laurent, can you comment on that?

Technically it should be possible, but I don't know if we have a use case for 
it.

-- 
Regards,

Laurent Pinchart

