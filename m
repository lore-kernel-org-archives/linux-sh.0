From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Jan 2010 04:02:53 +0000
Subject: Re: [PATCH] arch/sh: Fix build failure caused by missing semicolon / missing include
Message-Id: <20100118040253.GA13854@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201001180357.31594.PeterHuewe@gmx.de>
In-Reply-To: <201001180357.31594.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: Matt Fleming <matt@console-pimps.org>, Francesco Virlinzi <francesco.virlinzi@st.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 18, 2010 at 03:57:31AM +0100, Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> Date: Mon, 18 Jan 2010 03:48:31 +0100
> 
> This patch fixes a build failure[1][2] for all sh configs, by fixing a
> missing semicolon and a missing include file.
> 
> Build failure was introduced by the patch
> 	sh: fixed PMB mode refactoring [3]
> 	of Wed, 13 Jan 2010 09:31:48 +0000 (18:31 +0900)
> 
This was already caught and corrected, thanks anyways.
