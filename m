From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Wed, 19 Aug 2015 08:38:26 +0000
Subject: Re: [PATCH RFC v5 8/8] [media] media: rename the function that create pad links
Message-Id: <55D44082.6000600@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1439927113.git.mchehab@osg.samsung.com>
 <4b0c0aa7604f5202401997f946297c0b35c1b692.1439927113.git.mchehab@osg.samsung.com>
In-Reply-To: <4b0c0aa7604f5202401997f946297c0b35c1b692.1439927113.git.mchehab@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/18/2015 10:04 PM, Mauro Carvalho Chehab wrote:
> Now that a link can be either between two different graph
> objects, we'll need to add more functions to create links.
> So, rename the existing one that create links only between
> two pads as media_create_pad_link().
> 
> No functional changes.
> 
> This patch was created via this shell script:
> 	for i in $(find drivers/media -name '*.[ch]' -type f) $(find drivers/staging/media -name '*.[ch]' -type f) $(find include/ -name '*.h' -type f) ; do sed s,media_entity_create_link,media_create_pad_link,g <$i >a && mv a $i; done
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans

