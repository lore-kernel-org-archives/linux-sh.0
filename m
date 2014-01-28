From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 28 Jan 2014 10:20:33 +0000
Subject: Re: [PATCH V2 2/3] ARM: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <52E78471.7090101@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 28/01/14 08:35, Ben Dooks wrote:

> Yes, although I have been doing my initial testing with the RAM size
> limited to 1GiB of memory.
>
> I've found a couple of minor issues with the PCI bridge driver that
> so far have not actually fixed my problem which I hope to get reviewed
> and sent to the lists today.
>
> I am going to try the 'legacy' boot method today and see if I get the
> same problems, just to verify if the problem is with the fdt conversion
> or there is an issue with my board/code.

I've sent the test/fix patches to the list, and have tried building
with the legacy H2 code which seems to do the same thing.

I cannot seem to currently build a working 3.4-ltsi release, so will
have to wait to see if that will work on my board or not.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Geniu
