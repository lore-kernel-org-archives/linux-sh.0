From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 May 2015 21:56:20 +0000
Subject: Re: [Bug Report] DU: Error messages at boot log and can't show image on RGB Display.
Message-Id: <1784861.2EDxqCpMCH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <5552F298.2020201@jinso.co.jp>
In-Reply-To: <5552F298.2020201@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

On Wednesday 13 May 2015 15:43:36 Cao Minh Hiep wrote:
> Hi All.
> 
> We are testing Linux upstream version-4.1-rc2 on Lager.
> We found a Error message of DU(Display Unit) at boot logs:
> The Warning messages is showed as below:
> "rcar-du feb00000.display: encoder initialization failed, skipping"
> Then we tried to show a .bmp image on RGB Display via RGB port. But it
> didn't work.
> 
> Testing method:
> 1. Connect RGB Display to RGB port on Lager.
> 2. Show a BMP image on Display by this command:
> # bmap /dev/fb0 ./image.bmp
> 
> We'd like to report this problem first.
> There are no error message at version v4.0 stable.
> And showed the image on RGB Display normally at version v4.0 stable.
> We are looking for the error patch that added between v4.0 and v4.1-rc2.

I've tried v4.1-rc2 and haven't experienced that problem. It might be related 
to kernel configuration, could you please share your .config file ?

-- 
Regards,

Laurent Pinchart

