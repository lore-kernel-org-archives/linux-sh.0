From: Sakari Ailus <sakari.ailus@linux.intel.com>
Date: Thu, 10 Sep 2015 17:39:24 +0000
Subject: Re: [PATCH 2/2] [media] media-device: split media initialization and registration
Message-Id: <55F1C04C.1040906@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441890195-11650-1-git-send-email-javier@osg.samsung.com>
 <1441890195-11650-3-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1441890195-11650-3-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Javier Martinez Canillas wrote:
> Also, add a media_entity_cleanup() function that will destroy the
> graph_mutex that is initialized in media_entity_init().

media_device_init() and media_device_cleanup()?

-- 
Sakari Ailus
sakari.ailus@linux.intel.com
