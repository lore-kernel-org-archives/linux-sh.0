From: Shuah Khan <shuahkh@osg.samsung.com>
Date: Tue, 25 Aug 2015 18:55:41 +0000
Subject: Re: [PATCH v7 10/44] [media] media: rename the function that create pad links
Message-Id: <55DCBA2D.9090901@osg.samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1440359643.git.mchehab@osg.samsung.com>
 <f095b87884d435e296a455ab07a9951a74c0c3a6.1440359643.git.mchehab@osg.samsung.com>
In-Reply-To: <f095b87884d435e296a455ab07a9951a74c0c3a6.1440359643.git.mchehab@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/23/2015 02:17 PM, Mauro Carvalho Chehab wrote:
> Now that a link can be either between two different graph
> objects, we'll need to add more functions to create links.

Is this an incomplete sentence. Should it read: "either between
two different graph objects or two pads" ?

> So, rename the existing one that create links only between
> two pads as media_create_pad_link().

> 
> No functional changes.
> 
> This patch was created via this shell script:
> 	for i in $(find drivers/media -name '*.[ch]' -type f) $(find drivers/staging/media -name '*.[ch]' -type f) $(find include/ -name '*.h' -type f) ; do sed s,media_entity_create_link,media_create_pad_link,g <$i >a && mv a $i; done
> 

Didn't want to experiment with Coccinelle?? :)

> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> 

Changes look good to me. After fixing the commit log:

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>

thanks,
-- Shuah


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
