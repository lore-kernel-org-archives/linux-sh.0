From: Devendra Talegaonkar <devendra.talegaonkar@kpit.com>
Date: Mon, 15 Dec 2014 03:42:59 +0000
Subject: Re: [PATCH 0/2] Add VSP1 devices to DT for r8a7790 and r8a7791
Message-Id: <loom.20141215T043815-805@post.gmane.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410651385-13090-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Laurent Pinchart <laurent.pinchart <at> ideasonboard.com> writes:

> 
> Hi Cao Minh,
> 
> On Tuesday 30 September 2014 13:47:32 Cao Minh Hiep wrote:
> > Hi Laurent,
> > 
> > We are testing the upstream linux version on Lager.
> > I have tried to test VSP1 driver on r8a7790(Lager).
> > But I don't know how to test it.
> > Could you please tell the method to test it?
> 
> Sure.
> 
> I've attached the test script I use to configure the VSP1 pipeline to this e-
> mail.
> 
> Syntax: vsp1.sh dev cmd [...]
> 
> Supported commands:
>  - m2d | m2d-bru | m2d-crop | m2d-scale | m2m | m2m-crop | m2m-scale infmt 
> outfmt
>  - input index infmt
>  - output index outfmt
> 
>> 
> The input and output commands will invoke yavta to capture images from a WPF 
> (output) or stream images to an RPF (input). You can find a tarball with the 
> test frames I use at http://www.ideasonboard.org/frame-reference.tar.bz2, but 
> you can replace them with any binary test image.
> 
>
Hello,
I am testing VSP1 on lager board. You have mentioned that by invoking input
command, file can be streamed to RPF. Does that mean, If we stream the file
via input command we can seee it on LCD via VSPD0. If my understanding is
correct can you explain how to test that by setting plane priority? Because
VSPD0 can out put the data on predefined plane.
As I am stuck here, awaiting for the earliest response.

Regards, 
Devendra Talegaonkar


