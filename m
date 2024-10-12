Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B92C14A099
	for <linux-sh@vger.kernel.org>; Sat, 12 Oct 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728770321; cv=none; b=NV9xYF72o9RrhJMty047Hhbk/ok2i7/0X9uDgVyDTXq8vauCrd9uJBQg8graIPcuf/9wK7PCs3XecqnVcXsGgx6eQiZzX8hstRlALX+tz65IGfeRrqTUb60kuI3rEyyV2xQPQqFW+OWnxrHr3yaRyMdF3GbhhbG4U2CBZjxu0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728770321; c=relaxed/simple;
	bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=a5lUMdIgCdKb5WjWKF8415Dbb5KzFsQvLP215CQ64FaLfMbGtbldmxnNo24dMUNMF+XpKCp7tgnjximoUKV1K140D3yIzb914nrkY0aHha3kT0OPhiTt9hufUkVPPfhAqQua7KZrtDsWe+oowhpTvUVVSJY66xegZk31CRsN3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GH/x5Yc2; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH/x5Yc2"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e483c83dbso1327583b3a.3
        for <linux-sh@vger.kernel.org>; Sat, 12 Oct 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728770319; x=1729375119; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=GH/x5Yc2pioPSoKkVNOYAfR9qnKCpC8WSl2Nz9yVw2TxPikgxZrIJW2xjTJXEv98xM
         4OiSpXOpkneLZAuHLMQQp6PVa4YzDnVVUYRLxnfDh4k/uBnV9Ro80xLZVsI2UxjETC05
         fT86/u5zdfhzCn98Xlp/y2Bx4gXSv5LO+Fhxg3/dj5ImPRMM+75PugX8r3cCvzOKGKYy
         RSfzIYrDm56nJ9MsaTnO1iaf+UZ9sCXG2sz+8W4QSW6cLDPkOHal397v33OaEweJ/RGh
         ocbSZkFw9m+tLT7nHEZdUQMjXaid8Br6WB2Tb2Yur4PrMBlZ5opF9H3MeB2PZpgJVLSv
         XTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728770319; x=1729375119;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4p9zMCHyTvIHqWb+RiLLmYJIcUZSBcLyXxn110UCViQ=;
        b=ldRqEE+c84OegE/EJ+aAvlZgsh8x39doSy/hulr3cjwhMNsj/9QuhkeuzxUKYgQ6t6
         8Z0D6w3c0yTVIGY4oRzDf8HnUXlk9gESFkNwuIeEFLBf4S+2CzIjroobTEzLu/L4+diY
         /jGAO/tDqByqSGwPl6TSNl4j8avWNaQ4lLjSjOcDBwix9V2XWXzAnAI7KQpNpzbLTiRf
         foFhFhG/p53UD2pBXICMNveTVRxSZwPbFg1bsF7JQIaumMDDJyKKtCNx5YSYdN2P3B5U
         2s3InxMmrXPl718GD+byhiQueEDBbMetfyRy0TfS8hPijMnoTB+ASoeMEvCAPW/wSpy5
         4yxQ==
X-Gm-Message-State: AOJu0YyXVD5D4iko6TwM1hXTMad3l05sXqA8EsvehAkmUwgxPXGiQtr2
	Vl11VBZdKqHobf2gyviH9AWag8NNddY2+dA/RXGv82CQIYHrmQny/zp/CET+
X-Google-Smtp-Source: AGHT+IH0P88BwQTNsYAsyFPs866e7JS/4Fr11dhhdCIk0enrztuE92Sa5ZLYwh/bUMYJ9uNzz1QqCQ==
X-Received: by 2002:a05:6a00:9a1:b0:71d:f215:1d96 with SMTP id d2e1a72fcca58-71e37e287e7mr11888296b3a.6.1728770319335;
        Sat, 12 Oct 2024 14:58:39 -0700 (PDT)
Received: from [103.67.163.162] ([103.67.163.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e3e3ce90fsm3011756b3a.60.2024.10.12.14.58.38
        for <linux-sh@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:58:38 -0700 (PDT)
From: Josey Swihart <peeldona3@gmail.com>
X-Google-Original-From: Josey Swihart <joswihart@outlook.com>
Message-ID: <d5d6de0cf4a29308349b434bb837687a4881b978cc86e633dbfd25f9ce8d0de1@mx.google.com>
Reply-To: joswihart@outlook.com
To: linux-sh@vger.kernel.org
Subject: Yamaha Piano 10/12
Date: Sat, 12 Oct 2024 17:58:36 -0400
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

Hello,

I?m offering my late husband?s Yamaha piano to anyone who would truly appreciate it. If you or someone you know would be interested in receiving this instrument for free, please don?t hesitate to contact me.

Warm regards,
Josey
