From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 May 2010 07:47:12 +0000
Subject: Re: Master not compiling for r2dplus target
Message-Id: <20100518074712.GC30313@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTilPD8M0v8qF6a_pZduKs4nXVDbYMHunhdcN7OA6@mail.gmail.com>
In-Reply-To: <AANLkTilPD8M0v8qF6a_pZduKs4nXVDbYMHunhdcN7OA6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 18, 2010 at 04:43:06PM +0900, Alexandre Courbot wrote:
> Note that removing the culprit line results in a working kernel - on
> the other hand, declaring it beforehand I just get an unresolved
> symbol at link.
> 
It was one of those silly linux/ and asm/ header mixups. In any event,
it's fixed now.
