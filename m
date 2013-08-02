From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 02 Aug 2013 09:45:38 +0000
Subject: Re: [PATCH v5 4/9] v4l: Fix V4L2_MBUS_FMT_YUV10_1X30 media bus pixel code value
Message-Id: <51FB7FC2.2000607@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1375405408-17134-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1375405408-17134-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375405408-17134-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>



On 08/02/2013 03:03 AM, Laurent Pinchart wrote:
> The V4L2_MBUS_FMT_YUV10_1X30 code is documented as being equal to
> 0x2014, while the v4l2-mediabus.h header defines it as 0x2016. Fix the
> documentation.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
