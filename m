From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Fri, 02 Aug 2013 09:44:34 +0000
Subject: Re: [PATCH v5 1/9] media: Add support for circular graph traversal
Message-Id: <51FB7F82.5070500@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1375405408-17134-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1375405408-17134-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375405408-17134-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>



On 08/02/2013 03:03 AM, Laurent Pinchart wrote:
> The graph traversal API (media_entity_graph_walk_*) doesn't support
> cyclic graphs and will fail to correctly walk a graph when circular
> links exist. Support circular graph traversal by checking whether an
> entity has already been visited before pushing it to the stack.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Regards,

	Hans
