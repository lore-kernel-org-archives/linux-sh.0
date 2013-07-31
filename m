From: Sakari Ailus <sakari.ailus@iki.fi>
Date: Wed, 31 Jul 2013 20:40:31 +0000
Subject: Re: [PATCH v4 1/7] media: Add support for circular graph traversal
Message-Id: <20130731204030.GQ12281@valkosipuli.retiisi.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1375285954-32153-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1375285954-32153-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375285954-32153-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

On Wed, Jul 31, 2013 at 05:52:28PM +0200, Laurent Pinchart wrote:
> The graph traversal API (media_entity_graph_walk_*) doesn't support
> cyclic graphs and will fail to correctly walk a graph when circular
> links exist. Support circular graph traversal by checking whether an
> entity has already been visited before pushing it to the stack.

Thanks, Laurent!

Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

-- 
Cheers,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
