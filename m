From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 23 Jun 2014 21:05:12 +0000
Subject: Re: [PATCH 7/9] soc_camera: add support for dt binding soc_camera drivers
Message-Id: <53A89688.6080103@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk> <1402862194-17743-8-git-send-email-ben.dooks@codethink.co.uk> <Pine.LNX.4.64.1406190927110.22703@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1406190927110.22703@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, linux-media@vger.kernel.org, robert.jarzmik@free.fr, magnus.damm@opensource.se, horms@verge.net.au, ian.molton@codethink.co.uk, william.towle@codethink.co.uk

On 19/06/14 08:28, Guennadi Liakhovetski wrote:
> Hi Ben,
> 
> Thanks for an update.
> 
> On Sun, 15 Jun 2014, Ben Dooks wrote:
> 
>> Add initial support for OF based soc-camera devices that may be used
>> by any of the soc-camera drivers. The driver itself will need converting
>> to use OF.
>>
>> These changes allow the soc-camera driver to do the connecting of any
>> async capable v4l2 device to the soc-camera driver. This has currently
>> been tested on the Renesas Lager board.
>>
>> It currently only supports one input device per driver as this seems
>> to be the standard connection for these devices.
> 
> You ignored most of my comments to the previous version of this your 
> patch. Please, revisit.

Sorry, will go and have a look over this tomorrow.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
