From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Tue, 15 Sep 2015 11:01:54 +0000
Subject: Re: [PATCH v4 2/2] [media] media-device: split media initialization and registration
Message-Id: <55F7FAA2.2090605@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442313147-24566-1-git-send-email-javier@osg.samsung.com>
 <1442313147-24566-3-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1442313147-24566-3-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Javier,

Javier Martinez Canillas wrote:
> The media device node is registered and so made visible to user-space
> before entities are registered and links created which means that the
> media graph obtained by user-space could be only partially enumerated
> if that happens too early before all the graph has been created.
> 
> To avoid this race condition, split the media init and registration
> in separate functions and only register the media device node when
> all the pending subdevices have been registered, either explicitly
> by the driver or asynchronously using v4l2_async_register_subdev().
> 
> The media_device_register() had a check for drivers not filling dev
> and model fields but all drivers in mainline set them and not doing
> it will be a driver bug so change the function return to void and
> add a BUG_ON() for dev being NULL instead.
> 
> Also, add a media_device_cleanup() function that will destroy the
> graph_mutex that is initialized in media_device_init().
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Thanks!

For drivers/media/media-device.c, drivers/media/platform/omap3isp/isp.c
and include/media/media-device.h:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Laurent, could you ack these if you're fine with them?

They depend on Mauro's patches so they should be applied after them.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
