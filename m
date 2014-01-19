From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 19 Jan 2014 21:33:43 +0000
Subject: Re: debug uart for shmobile platforms
Message-Id: <3557246.OF360HDnfJ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <52D8FF13.3010709@codethink.co.uk>
In-Reply-To: <52D8FF13.3010709@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Friday 17 January 2014 09:59:47 Ben Dooks wrote:
> Laurent has posted support for this previously, is there a chance this
> could be sorted out for the next release as it is /very/ useful when
> doing any development work.

I suppose you're referring to the earlyprintk patch. I'm afraid I haven't had 
time to clean it up yet.

The patch is currently very specific to Lager. I'd like to change that to a 
single .c file could be used for all serial ports of the same model, probably 
with a Kconfig option to select the port number and/or base address. I'm not 
sure how the virtual address should be computed though, any help would be 
appreciated.

-- 
Regards,

Laurent Pinchart

