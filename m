From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 May 2014 01:17:33 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: Correct SYS-DMAC clock defines
Message-Id: <20140513011732.GE30252@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1399920573-30947-1-git-send-email-geert+renesas@glider.be>
 <1879564.Q0Zk545mJH@avalon>
In-Reply-To: <1879564.Q0Zk545mJH@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Mon, May 12, 2014 at 09:48:59PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Monday 12 May 2014 20:49:33 Geert Uytterhoeven wrote:
> > R-Car M2 has two MSTP bits for SYS-DMAC, not one.
> > Also bring the naming in sync with the documentation.
> > 
> > This issue was introduced in v3.14, in commit
> > 4d8864c9e94ec727f1c675b9f6921525c360334b ("ARM: shmobile: r8a7791: Add
> > clock index macros for DT sources").
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> > ---
> > I believe there are no users of the incorrect definition.

Thanks, I will queue this up.
As there are it does not seem to be very urgent so I will target
it at v3.16.
