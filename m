From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Thu, 10 Sep 2015 13:58:53 +0000
Subject: Re: [PATCH v8 01/55] [media] media: create a macro to get entity ID
Message-Id: <CABxcv=myNegKSr7xtrgV7BHqiTLMFCicLZtr1Md8m_wS8O52og@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1440902901.git.mchehab@osg.samsung.com>
	<6185117c4ad70fd3e1c780689e0ad2407fdf1294.1440902901.git.mchehab@osg.samsung.com>
In-Reply-To: <6185117c4ad70fd3e1c780689e0ad2407fdf1294.1440902901.git.mchehab@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

On Sun, Aug 30, 2015 at 5:06 AM, Mauro Carvalho Chehab
<mchehab@osg.samsung.com> wrote:
> Instead of accessing directly entity.id, let's create a macro,
> as this field will be moved into a common struct later on.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
>

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
