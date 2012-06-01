From: "H. Peter Anvin" <hpa@zytor.com>
Date: Fri, 01 Jun 2012 03:38:40 +0000
Subject: Re: [PATCH] lib/decompress_unxz.c: removing all memory helper functions
Message-Id: <4FC83940.9010708@zytor.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <20120528070336.GM3377@game.jcrosoft.org> <4FC82D89.1040108@hp.com>
In-Reply-To: <4FC82D89.1040108@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 05/31/2012 07:48 PM, Thavatchai Makphaibulcboke wrote:
> On 05/28/2012 01:03 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
>> can we do not duplicate those functions?
>>
>> Best Regards,
>> J.
> 
> Thanks J for the comment.  Unfortunately, there is no easy way to share
> files among different architectures' preboot environment.  We have the
> choices either to have each architecture define its own copies or the
> decompressor defines them.  I believe the former is preferable.  As
> Lasse also pointed out, this way any specific architecture could provide
> an architectural dependent optimized version, if it chooses to.
> 

We could always make a source code library, like we already in effect
have for the compression functions themselves.

	-hpa

