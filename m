From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Date: Tue, 18 Mar 2008 07:26:16 +0000
Subject: Re: [PATCH] Use relative path when creating include/asm/{mach,cpu}
Message-Id: <47DF6E98.4030609@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <47DEC594.6010502@gmail.com>
In-Reply-To: <47DEC594.6010502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Stuart MENEFY wrote:
> 
> I've not had a chance to check this, but are you sure this will work
> when building with O= (aka KBUILD_OUTPUT) set?
> 

No I'm not sure at all ;)

Actually I've never used this building option and after a quick
look the patch probably doesn't work as is.

Thanks
		Franck
