From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 20 Oct 2008 17:44:09 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <Pine.LNX.4.64.0810201941050.7787@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 20 Oct 2008, Paul Mundt wrote:

> > Last I checked - just before sending the previous email - it was not yet 
> > committed, but it is racy, you know:-)
> > 
> Then I will merge the original in my tree and we can then focus on
> getting the API changed properly, and making an incremental transition
> that doesn't break all of the existing users in the process.

Shall I ask Mauro to not merge the v4l part? It might still work...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
