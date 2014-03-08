From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 08 Mar 2014 11:07:40 +0000
Subject: Re: [PATCH 5/5] rcar_vin: add devicetree support
Message-Id: <Pine.LNX.4.64.1403081148050.18310@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk>
 <1394197299-17528-6-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394197299-17528-6-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-kernel@vger.kernel.org, magnus.damm@opensource.se, linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk

Hi Ben,

On Fri, 7 Mar 2014, Ben Dooks wrote:

> Add support for devicetree probe for the rcar-vin
> driver.

Thanks for the patch. I'm afraid I don't quite understand how it is 
supposed to work though. AFAICS, the rcar_vin driver currently doesn't 
support asynchronous probing, so, your code is relying on a specific 
probing order? Besides, as of now soc-camera doesn't support OF probing. 
You mentioned, that you have a patch for soc-camera to add OF support. I 
think that and async probing for rcar_vin should be committed before this 
patch becomes meaningful.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
