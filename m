Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445963;
	b=TJPX6N7bNiXA1lAu0rf7qQkxTL/dUnWAdCyggO47qd1lt9IoqQ7vyMjIMGzF9G6/KkdP
	 9ZEGgrkqPtw6mVSbarGnFOBK5K7o4qeRnpysPqg6+FAmmVHnTyIHuKU+W/lhoLLsNr2It
	 9WjSx9Y24t37mC1N37dnTDlEFGmDLmBxDY7DXsrw7lsnS08MuDVC+QZjpVjHndpozEh26
	 Qs+8VDK+IT/9bsQAPFLYxhGz63C6mwp2gHHE/xplDHXPOMF6T7OHQ4YSfmYV8poNvNXAf
	 U+an5/7OQnvSfvGgXU6uGvThaBmLyQLWo/9V5ojm5LV22qTdv8tdI6Sz2MWqn3+4shA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445963;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zl/f2wJSs7EBtkSOpWvBu5ePvHb2i/QJ8ZYUWakxOUk=;
	b=EjBist7q0ZqMY/U2BIn0CZNvf9rD7PukQmvS7wTV3GrBvrC+Qn5lC891EWzfbw2yf9w0
	 MCTjMq3Q/FtPawyKucPkW6w1xZiZcd0etqWvecpnmEBFaJ9dU2vJtis6D/cwAEoVomErP
	 24Z0OtDaTOd4NwdZHHxZPlpCOthC46uKSh5HuXnWfHT/xPcsNHeBew7OsupPWuNkv9CjG
	 pDrgDLUN19+kYDEHjeCcEyzQqVz96bcDs7wEhmsronc8QNdkb8pbPAAUXJudYONDjiAg/
	 yqXTAKoqLOgaE5zL+u4aUKjbHPCqjzUkA0nKhSg3Q/sYFVtuDmdWsI6dcdCJaU2j6KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKFivSUh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 60725606A33F;
	Mon, 23 Nov 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKFivSUh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 98FE71F000D2;
	Mon, 23 Nov 2026 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795445962;
	bh=zl/f2wJSs7EBtkSOpWvBu5ePvHb2i/QJ8ZYUWakxOUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UKFivSUhrAHDP8XDUh7QplsMKH0uV9ogR0GisgMhhsaNKUCz8lzRK374yfK1HwTmk
	 12HyPmDAphb/fwGAsBmoWMNkoM2DI3tQzlRidGax2QzhLAdyTJ4nLZyny4pdndoMWe
	 Sj14cxXkCQwyJh4LIMxWKUcNfUCBgkCV9OmkfvJXSQMSVS+u45C3lO4G/2HbbPT3NM
	 lxvYLSBklpsSHepKZ2frpAUmRCnXfmf89H5OyrxLvQnmtdE1wpD9bP1H3qfsliviey
	 65uFiBpAPrMuaWrNCmiRhb1ndT0JbRtzBo1SD0bB3GJOLc+npE1ow4lD2K0c5SrMAw
	 /PwpDL6atmRtA==
Date: Mon, 23 Nov 2026 15:59:18 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Kent Gibson <warthog618@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
Message-ID: <tdc6h325jthjgyik2ne4oistkm563maoc2cpnffqu7hh34tpl7@oscripzv4dwq>
References: <20261123085723.156933-1-arnd@kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123085723.156933-1-arnd@kernel.org>

On Mon, Nov 23, 2026 at 09:57:21AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These two patches are left from my cleanup series, finishing off the
> work to turn off CONFIG_GPIOLIB_LEGACY by default, and removing the
> include/linux/gpio.h header.
> 
> This was planned for 7.3 originally[1], but kept conflicting with
> ongoing cleanups for the broken rsk7203 board. I've skipped the
> oneline rsk change now, which will be fixed properly by Dmitry's
> patch [2].

What is the base commit? It doesn't apply on top of linux-next.

Bart
