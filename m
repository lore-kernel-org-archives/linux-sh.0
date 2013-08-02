From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 02 Aug 2013 09:55:30 +0000
Subject: Re: [PATCH v5 8/9] vsp1: Fix lack of the sink entity registration for enabled links
Message-Id: <51FB8212.1070800@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1375405408-17134-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1375405408-17134-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375405408-17134-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>



On 08/02/2013 03:03 AM, Laurent Pinchart wrote:
> From: Katsuya Matsubara <matsu@igel.co.jp>
> 
> Each source entity maintains a pointer to the counterpart sink
> entity while an enabled link connects them. It should be managed by
> the setup_link callback in the media controller framework at runtime.
> However, enabled links which connect RPFs and WPFs that have an
> equivalent index number are created during initialization.
> This registers the pointer to a sink entity from the source entity
> when an enabled link is created.
> 
> Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
