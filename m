From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 05 Jun 2014 10:05:25 +0000
Subject: Re: RFC/FYI - shdmac dma support
Message-Id: <539040E5.3090304@codethink.co.uk>
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

I am currently working on finishing up the code to generate
the register configuration values based on the slave configurations
which should mean we can eliminate the hard-coded CHCR values and
addresses from the configuration.

Laurent, is this what you are after, and is it ok if this is on
list tomorrow for review?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
