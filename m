From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Thu, 10 Sep 2015 18:33:32 +0000
Subject: Re: [PATCH 2/2] [media] media-device: split media initialization and registration
Message-Id: <55F1CCFC.4080604@osg.samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441890195-11650-1-git-send-email-javier@osg.samsung.com>
 <1441890195-11650-3-git-send-email-javier@osg.samsung.com>
 <55F1C04C.1040906@linux.intel.com>
In-Reply-To: <55F1C04C.1040906@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello Sakari,

On 09/10/2015 07:39 PM, Sakari Ailus wrote:
> Javier Martinez Canillas wrote:
>> Also, add a media_entity_cleanup() function that will destroy the
>> graph_mutex that is initialized in media_entity_init().
> 
> media_device_init() and media_device_cleanup()?
>

Right, sorry about that. I'll fix it.

Thanks!
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
