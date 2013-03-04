From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Mar 2013 04:03:12 +0000
Subject: Re: what does this do?
Message-Id: <20130304040311.GB26475@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20130302232729.GA2491@debian.localdomain>
In-Reply-To: <20130302232729.GA2491@debian.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 03, 2013 at 07:27:29AM +0800, horse wrote:
> 
>   here are a portion of  build-in asm code  :
> 
>     "  .long 661b\n"              	\
>     "  .long 663f\n"	    	\
>     "  .byte %c0\n"             /		\
>     "  .byte 662b-661b\n"       		\
>     "  .byte 664f-663f\n"       
> 
> what is 661b ,etc ,what does it mean?
> 
> thanks!

If you have to ask this question you probably shouldn't be modifying this
code.

Secondly, what exactly does this have to do with this mailing list?
