From: Sakari Ailus <sakari.ailus@iki.fi>
Date: Fri, 03 Apr 2015 21:46:33 +0000
Subject: Re: [PATCH v1.1 07/14] media: omap3isp: remove unused clkdev
Message-Id: <20150403214633.GQ20756@valkosipuli.retiisi.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1428097502-19593-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1428097502-19593-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

On Sat, Apr 04, 2015 at 12:45:02AM +0300, Laurent Pinchart wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> No merged platform supplies xclks via platform data.  As we want to
> slightly change the clkdev interface, rather than fixing this unused
> code, remove it instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

-- 
Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
