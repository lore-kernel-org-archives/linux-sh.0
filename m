From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Feb 2008 05:21:48 +0000
Subject: Re: [PATCH] sh: Storage class should be before const qualifier
Message-Id: <20080226052148.GD19814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080217143835.GA9231@distanz.ch>
In-Reply-To: <20080217143835.GA9231@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 17, 2008 at 03:38:35PM +0100, Tobias Klauser wrote:
> The C99 specification states in section 6.11.5:
> 
> The placement of a storage-class specifier other than at the
> beginning of the declaration specifiers in a declaration is an
> obsolescent feature.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Applied, thanks.
