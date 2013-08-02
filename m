From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 02 Aug 2013 09:45:14 +0000
Subject: Re: [PATCH v5 3/9] videobuf2: Clarify queue_setup() and buf_prepare() usage documentation
Message-Id: <51FB7FAA.2040508@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1375405408-17134-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1375405408-17134-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375405408-17134-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>



On 08/02/2013 03:03 AM, Laurent Pinchart wrote:
> Explain how the two operations must handle formats and validate buffer
> sizes when used with VIDIOC_CREATE_BUFS.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
