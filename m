Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2ED2E6CD5;
	Sun, 19 Apr 2026 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624861; cv=none; b=j+ack43PPeGPXOV0vPSUY9GxJwd0EvlbjCMFl0GmeOt/Q3piPwAFHX35JpVaRQzVSjqEls4v3JX4hTFm21eW+SeHBmClf4MhF+jmWLnP256Sy2h9o3encOJeGxdKf+BXKPWdANqhNdk17qLXknf9lAX14+g2O0mAsS5fG0VeKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624861; c=relaxed/simple;
	bh=s/cK1MRs+UpLqMr+gI7bvFuql5/00YzVgXKXn9qa8tU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rYpxHz79p28Gr929VB6EAp9iMtZeeeKwHKLGfqryyeuZpU0OtlsItWaR6CTuFl9uwG3jlxpgh3smMwtaUGWUCCkaZKHEO4eeOLRY5WEvh8AMMUtAdHY68nQlcTFJ80U7n9K3HyewRaQvh+XdPnuKjr0El8OVxqKHFY5VF5W2OJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 773043ED65;
	Sun, 19 Apr 2026 18:54:16 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 19 Apr 2026 20:54:16 +0200
From: Artur Rojek <contact@artur-rojek.eu>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Mike Rapoport <rppt@kernel.org>, Rich Felker
 <dalias@libc.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org,
 linux-sh@vger.kernel.org
Subject: Re: [PATCH] sh: fix fallout from ZERO_PAGE consolidation
In-Reply-To: <20260417103208.1217010-1-rppt@kernel.org>
References: <20260417103208.1217010-1-rppt@kernel.org>
Message-ID: <3e6c12299bf02b196af45a78a04aee08@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Score: -100
X-GND-Cause: dmFkZTGCyvL0s1kfZ/yDYKzPK+b0AU5ypWg+FeGE9f1B0PPst4vgjkFhnH9EGFLXP0VnSoK6BBzlRjrI7CuJUqPXxtlT9e1bSTJPJl850+jG2f+T01rDi87I7/agzjwlApRKzK3tBauphqM4cUMugyigGGKBy81Q7gHRIUWmHntVQn5Yzi6RYnqfG+0GlKRZyWsR8K3PI0jKl0w9geGzrEewDaUb/Im6md3akrchqy/J7zTENY7cyu1eeq61o/qFm1IlKIE4AiIeBFkzyfbvY+NJ6lcEpF+onYO/YhnMUhlt0FZf378C+7xNSYEN/qG3HHJfe2YQWmALwC5I51YMvegnSC6ePQBrsTXdzfTXOmFd9dQfElCD1xrum0cigXUSA9woxLSWmzH75fU/7vS2xcxT6aHw5b1gbyHBqqi8+/1/l8Sx5mRKVfCEC9Y011kHoFOHYhMjSCN7UwlWtOyRj4IBjXz3DkKy+zsUfiX8HoGqL4L8hNJZ7rPxBM/BVQEtJ6XRoVzK7CV/uddGIP5RvwTxVKzpfSM7pqkeL1h1+J3UqL7DcYqrwVMOjQc9KmBFt547NiF1wPxXb7gGMneg1yhNFX8A1KSU3DbY1TZ53ZbvfqNpOowE9fwF6E54I3bBFhOoA2Ev/P+b7wlv5WCDBpu7Knb2e9wWdvOcT06iFa8HcGt0Ow
X-GND-State: clean

On 2026-04-17 12:32, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Consolidation of empty_zero_page declarations broke boot on sh.
> 
> sh stores its initial boot parameters in a page reserved in
> arch/sh/kernel/head_32.S. Before commit 6215d9f4470f ("arch, mm:
> consolidate empty_zero_page") this page was referenced in C code as an
> array and after that commit it is referenced as a pointer.
> 
> This causes wrong code generation and boot hang.
> 
> Declare boot_params_page as an array to fix the issue.
> 
> Reported-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Fixes: 6215d9f4470f ("arch, mm: consolidate empty_zero_page")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

I confirm this fixes boot issues on SEGA Dreamcast (sh4).

Tested-by: Artur Rojek <contact@artur-rojek.eu>

> ---
>  arch/sh/include/asm/setup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> base-commit: 43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9
> 
> diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
> index 63c9efc06348..8488f76b48b4 100644
> --- a/arch/sh/include/asm/setup.h
> +++ b/arch/sh/include/asm/setup.h
> @@ -7,7 +7,7 @@
>  /*
>   * This is set up by the setup-routine at boot-time
>   */
> -extern unsigned char *boot_params_page;
> +extern unsigned char boot_params_page[];
>  #define PARAM boot_params_page
> 
>  #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
