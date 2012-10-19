From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Oct 2012 22:20:16 +0000
Subject: [PATCH 0/2] media: V4L2: clock and asynchronous registration
Message-Id: <Pine.LNX.4.64.1210192358520.28993@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi all

During a recent discussion of a V4L2 DT RFC it has become apparent, that 
we first need two more preliminary steps, before implementing DT: we need 
a (temporary) V4L2 clock implementation and asynchronous subdevice 
registration. As follow ups to this mail I'm posting two patches, 
implementing those. I have actually been able to get that to work with an 
soc-camera system (sh7372), but respective soc-camera and bridge patches 
are still raw, need a lot of clean up, and I don't know when I'll be able 
to do that. So, I decided to first dump these two patches to the list, and 
then see when I find time for the rest.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
