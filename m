From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 02 Jul 2014 07:56:33 +0000
Subject: Re: [PATCH v7] media: vb2: Take queue or device lock in mmap-related vb2 ioctl handlers
Message-Id: <10104979.PzNG1tgbGn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201308061239.27188.hverkuil@xs4all.nl> <2051293.PjTd9YAWz0@avalon> <53B3A7CB.8020901@xs4all.nl>
In-Reply-To: <53B3A7CB.8020901@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Sasha Levin <sasha.levin@oracle.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-media@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>, Katsuya MATSUBARA <matsu@igel.co.jp>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>

Hi Hans,

On Wednesday 02 July 2014 08:33:47 Hans Verkuil wrote:
> For now it is -ENOTIME for me. It's on my TODO list, but there are a number
> of other things I want to finish first.

No worries, I know how it feels. I just wanted to make sure you hadn't missed 
my e-mail.

-- 
Regards,

Laurent Pinchart

