From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 05 Jun 2014 17:24:39 +0000
Subject: Re: RFC/FYI - shdmac dma support
Message-Id: <5390A7D7.2030701@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 04/06/14 17:14, Ben Dooks wrote:
> Laurent asked for a current state, so this is the series as I
> currently have which is in the middle of being re-worked for
> submission.
> 
> It is also available at:
> 
> 	http://git.codethink.co.uk/linux.git bjdooks/shdma-dev1

I've pushed out  bjdooks/shdma-dev4 with the comments that have
been made on the first branch sorted out.

- Fixed dmac0/dmac1 compatible name
- Sorted out mux driver use of driver private data
- Fixed ordering of dmac clocks
- Fixed missing set_slave call

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
