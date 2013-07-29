From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 29 Jul 2013 19:27:02 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove unused mach/sdhi*.h headers
Message-Id: <1622122.kQoM82v6OE@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1375125846-25149-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375125846-25149-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday 29 July 2013 21:24:06 Laurent Pinchart wrote:
> The headers are not used anymore, remove them.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Scratch this, my bad, I hadn't realized the headers were still needed by 
arch/arm/boot/compressed/sdhi-mobile.c. Sorry for the noise.

-- 
Regards,

Laurent Pinchart

